class ALAssetsLibrary
  def album_name(album_name, &block)
    create_if_missing = true
    album_found = nil
    #stop is a BOOL*
    enumerateGroupsWithTypes(ALAssetsGroupAlbum, usingBlock:proc {|group, stop|
      if group.nil?
        if album_found.nil? && create_if_missing
          create_album(album_name, &block)
        else
          block.call(self, album_found)
        end
      else
        if group.valueForProperty(ALAssetsGroupPropertyName) == album_name
          album_found = group
          stop[0] = true
        end
      end
    }, failureBlock:proc {|error|
      #p "failed to enumerate albums. Error: #{error.localizedDescription}"
      block.call(self, nil)
    })
  end

  def create_album(album_name, &block)
    addAssetsGroupAlbumWithName(album_name, resultBlock:proc {|group|
      block.call(self, group)
    }, failureBlock:proc {|error|
      #p "error creating album"
      block.call(self, nil)
    })
  end
end
