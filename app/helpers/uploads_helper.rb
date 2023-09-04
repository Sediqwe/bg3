module UploadsHelper
    def stat(uploadtype)
        stat0 = Line.where(datatype: 1, uploadtype: uploadtype).size
        stat1 = Line.where(datatype: 2, uploadtype: uploadtype).where("oke IS NULL OR oke = ?", false).size
        stat2 = Line.where(datatype: 2, uploadtype: uploadtype, oke: true).size
    
        return {
          total_lines: stat0,
          translated_lines: stat1 + stat2,
          proofread_lines: stat2
        }
      end
end
