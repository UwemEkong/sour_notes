package edu.ben.backend.resource;
import edu.ben.backend.model.dto.MusicDTO;
import edu.ben.backend.service.MusicService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "api/music", produces = "application/json")
public class MusicResource {

    private final MusicService musicService;

    public MusicResource(MusicService musicService) {
        this.musicService = musicService;
    }

    @GetMapping(value="/getAllMusic/{sortBy}")
    public List<MusicDTO> getAllMusic(@PathVariable String sortBy){

        return musicService.getAllMusic(sortBy);
    }


    @GetMapping(value="/getSongsOnly")
    public List<MusicDTO> getSongsOnly() {
        return musicService.getSongsOnly();
    }

    @PostMapping(value="/searchMusic")
    public List<MusicDTO> searchMusic(@RequestBody MusicDTO searchCriteria){

        return musicService.searchMusic(searchCriteria);
    }

}
