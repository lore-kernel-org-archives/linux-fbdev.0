From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Oct 2010 08:26:26 +0000
Subject: Re: [PATCH] fbdev: add a function to parse further EDID Detailed
Message-Id: <AANLkTimsCPV_tR6o7z8_7BRr2BHrkdNKrJQtMKwVySKc@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Thu, Oct 21, 2010 at 01:56, Dave Airlie <airlied@gmail.com> wrote:
> On Fri, Aug 20, 2010 at 5:23 PM, Erik Gilling <konkers@google.com> wrote:
>> Guennadi,
>>    Not sure how you're using the edid but you can get all 4 DTDs by
>> calling fb_edid_to_monspecs() then calling fb_videomode_to_var() on
>> each of the entries in monspecs.modedb.  This is still lacking as
>> modern monitors/tvs can have multiple EDID blocks.  My recent patch
>> [1] is a proposal for addressing that.
>
> If someone is really interested in fixing up the fbdev EDID parser
> they probably should look at sharing the drm EDID parser, its a lot
> more complete and came mostly from the EDID parser in the X server.

Funny, where do you think the fbdev EDID parser came from?

So I can only conclude that instead of updating/improving the fbdev one,
a new one was duplicated/created, the DRM one? ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
