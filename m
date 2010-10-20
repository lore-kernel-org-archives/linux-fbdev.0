From: Dave Airlie <airlied@gmail.com>
Date: Wed, 20 Oct 2010 23:56:13 +0000
Subject: Re: [PATCH] fbdev: add a function to parse further EDID Detailed
Message-Id: <AANLkTink7AjKVh8U8vg+tR-NZuPnq6NwZp0PvMY++Jx9@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Fri, Aug 20, 2010 at 5:23 PM, Erik Gilling <konkers@google.com> wrote:
> Guennadi,
> =A0 =A0Not sure how you're using the edid but you can get all 4 DTDs by
> calling fb_edid_to_monspecs() then calling fb_videomode_to_var() on
> each of the entries in monspecs.modedb. =A0This is still lacking as
> modern monitors/tvs can have multiple EDID blocks. =A0My recent patch
> [1] is a proposal for addressing that.

If someone is really interested in fixing up the fbdev EDID parser
they probably should look at sharing the drm EDID parser, its a lot
more complete and came mostly from the EDID parser in the X server.

Dave.
