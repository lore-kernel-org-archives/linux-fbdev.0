From: Krzysztof Helt <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] tdfxfb: make use of DDC information about connected
 monitor
Date: Wed, 25 Mar 2009 20:25:04 +0100
Message-ID: <20090325202504.1a4690a4.krzysztof.h1@poczta.fm>
References: <20090325063616.16A371D789D@f39.poczta.interia.pl>
	<20090325090655.19fe3af2@hyperion.delvare>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090325090655.19fe3af2-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On Wed, 25 Mar 2009 09:06:55 +0100
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> On 25 Mar 2009 07:36:15 +0100, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org wrote:

> > If you can test the BT869 driver for a Voodoo3 card (mentioned
> > in the i2c-voodoo3 doc) it would be great.
> 
> The bt869 driver was never ported to Linux 2.6, so no, I can't test it.
> Not that I believe that the driver as it existed made much sense
> anyway. It was more of an afternoon hack than anything else.
> Controlling the video output using the BT869 should really be up to the
> video driver (framebuffer or X) and not to the user.
> 

I see. I found that there is something like bt869 driver in the lm-sensors
package but I didn't know details.

Thanks for answer,
Krzysztof


----------------------------------------------------------------------
Udar sloneczny prezesa Kaczynskiego... >>> http://link.interia.pl/f2083
