package edu.ben.backend.resource;
import edu.ben.backend.model.dto.SongDTO;
import edu.ben.backend.service.SongService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "api/song", produces = "application/json")
public class SongResource {

    private final SongService songService;

    public SongResource(SongService songService) {
        this.songService = songService;
    }

    @GetMapping(value="/getAllSongs")
    public List<SongDTO> getAllSongs(){

        return songService.getAllSongs();
    }

    @PostMapping(value="/searchSongs")
    public List<SongDTO> searchSongs(@RequestBody SongDTO searchCriteria){

        return songService.searchSongs(searchCriteria);
    }

}
