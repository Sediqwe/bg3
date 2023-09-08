module UploadsHelper
    def stat(upload)
        stat0 = Line.where(datatype: 1, upload_id: upload).size
        stat1 = Line.where(datatype: 2, upload_id: upload).where("oke IS NULL OR oke = ?", false).size
        stat2 = Line.where(datatype: 2, upload_id: upload, oke: true).size
    
        return {
          total_lines: stat0,
          translated_lines: stat1 + stat2,
          proofread_lines: stat2
        }
      end
end
