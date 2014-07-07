From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Mon, 07 Jul 2014 20:52:26 +0000
Subject: Re: [PATCH] video: fbdev: core: fbmon.c: Cleaning up useless assignment of function parameter
Message-Id: <CAFo99gaWUTzbxgmA6ahtFhCOBog1iYBx1oSvr9m_rAQgcNq6oA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404667555-14675-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
	<CAMuHMdV++wyFLbqmnqEBTrWdgTNKpy=r9-mYFhQGCj7kUUUhKQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV++wyFLbqmnqEBTrWdgTNKpy=r9-mYFhQGCj7kUUUhKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, David Ung <davidu@nvidia.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

2014-07-07 22:43 GMT+02:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Sun, Jul 6, 2014 at 7:25 PM, Rickard Strandqvist
> <rickard_strandqvist@spectrumdigital.se> wrote:
>> Remove assignment of function parameter, that has no effect outside the function
>>
>> This was found using a static code analysis program called cppcheck
>>
>> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
>> ---
>>  drivers/video/fbdev/core/fbmon.c |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
>> index 5b0e313..71ec1ab 100644
>> --- a/drivers/video/fbdev/core/fbmon.c
>> +++ b/drivers/video/fbdev/core/fbmon.c
>> @@ -1481,7 +1481,6 @@ int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
>>  }
>>  void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
>>  {
>> -       specs = NULL;
>
> I guess the intention was:
>
> memset(specs, 0, sizeof(struct fb_monspecs));


Hi Geert!

Yeah, maybe. Just looks to be a little too elementary mistake..?

But do you want me to change it to that?

With a:
if(specs)
  memset()

maybe..?


Kind regards
Rickard Strandqvist
