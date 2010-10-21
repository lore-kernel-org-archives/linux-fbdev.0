From: Dave Airlie <airlied@gmail.com>
Date: Thu, 21 Oct 2010 08:47:30 +0000
Subject: Re: [PATCH] fbdev: add a function to parse further EDID Detailed
Message-Id: <AANLkTim6CiyD0uk9x7Bu_o_6VM4_3nnrT5cMiSOL+Xhg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, Oct 21, 2010 at 6:26 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Oct 21, 2010 at 01:56, Dave Airlie <airlied@gmail.com> wrote:
>> On Fri, Aug 20, 2010 at 5:23 PM, Erik Gilling <konkers@google.com> wrote:
>>> Guennadi,
>>> =A0 =A0Not sure how you're using the edid but you can get all 4 DTDs by
>>> calling fb_edid_to_monspecs() then calling fb_videomode_to_var() on
>>> each of the entries in monspecs.modedb. =A0This is still lacking as
>>> modern monitors/tvs can have multiple EDID blocks. =A0My recent patch
>>> [1] is a proposal for addressing that.
>>
>> If someone is really interested in fixing up the fbdev EDID parser
>> they probably should look at sharing the drm EDID parser, its a lot
>> more complete and came mostly from the EDID parser in the X server.
>
> Funny, where do you think the fbdev EDID parser came from?

Guess where it came from 4-5 years ago, X moved on a long way since then.

> So I can only conclude that instead of updating/improving the fbdev one,
> a new one was duplicated/created, the DRM one? ;-)

Pretty much,

the fbdev edid parser had built up a lot of one-off fixes for various
scenarios, has had no major testing in non-embedded environments, it
was felt a clean start with the X one would have a better chance of
working without regressing the fbdev one.

I would like to provide the DRM one in a compatible manner to fbdev
users, its not a top priority for me but if someone really wants a
decent EDID parser that can handle modern monitors scenarios then I
would recommend investing in sharing that code than trying to make the
fbdev one do all the stuff it can't do now.

The fbdev edid parser last seen any major code updates in 2008 and the
fb layer was missing any sort of active maintainer which also led to
that decision.

Dave.
