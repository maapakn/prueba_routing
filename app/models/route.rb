class Route < ApplicationRecord
  include Filterable
  mount_uploader :file, AttachmentUploader

  after_create :delay_import_data, if: Proc.new{|r| r.callback?}

  has_many :stops, inverse_of: :route, dependent: :destroy

  validates :name_load, :date, presence: true
  validates :route, uniqueness: {message: 'Esta ruta ya existe'}

  scope :by_name_load, -> (nload) { where(name_load: nload)}
  scope :by_date, -> (date) { where(date: date)}
  scope :by_hour_start, -> (hstart) { where(hour_start: hstart)}

  def import
    file = self.file
    sheet = Roo::CSV.new(file.path)
    (2..sheet.last_row).each do |row|
      if sheet.cell(row-1,1) && sheet.cell(row-1,2) && sheet.cell(row-1,3) && sheet.cell(row-1,4) && sheet.cell(row-1,5)
        if row == 2
          if self.update(route: sheet.cell(row,1))
            stop = Stop.create(
              route: self,
              hour_arrival: sheet.cell(row,2),
              load: sheet.cell(row,3),
              latitude: sheet.cell(row,4),
              longitude: sheet.cell(row,5)
            )
          else
            self.destroy
          end
        elsif Route.find_by(route: sheet.cell(row,1)).present?
          route = Route.find_by(route: sheet.cell(row,1))
          stop = Stop.create(
            route: route,
            hour_arrival: sheet.cell(row,2),
            load: sheet.cell(row,3),
            latitude: sheet.cell(row,4),
            longitude: sheet.cell(row,5)
          )
        elsif sheet.cell(row,1).present?
          new_route = Route.new(
            route: sheet.cell(row,1),
            name_load: name_load,
            date: date,
            callback: false
          )
          if new_route.save
            stop = Stop.create(
              route: new_route,
              hour_arrival: sheet.cell(row,2),
              load: sheet.cell(row,3),
              latitude: sheet.cell(row,4),
              longitude: sheet.cell(row,5)
            )
          end
        end
      end
    end
  end

  private

  def delay_import_data
    self.delay(queue: 'import_data').import
  end
end
