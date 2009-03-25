From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] tdfxfb: make use of DDC information about connected
  monitor
Date: Wed, 25 Mar 2009 09:06:55 +0100
Message-ID: <20090325090655.19fe3af2@hyperion.delvare>
References: <20090325063616.16A371D789D@f39.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090325063616.16A371D789D-PzGfQPfZplqOitzWlErfBcT2TbGLZofU@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Cc: Krzysztof Helt <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>, Linux-fbdev-devel <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On 25 Mar 2009 07:36:15 +0100, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org wrote:
> I have tested it on Voodoo3 3000 AGP and Voodoo5 AGP with LCD panel
> and CRT monitor. It is reallycool on CRT monitor - it returns
> a resolution with high refresh rate and quite useful
> (on my 15" CRT it is 800x600 at 85Hz).
> 
> If you can test the BT869 driver for a Voodoo3 card (mentioned
> in the i2c-voodoo3 doc) it would be great.

The bt869 driver was never ported to Linux 2.6, so no, I can't test it.
Not that I believe that the driver as it existed made much sense
anyway. It was more of an afternoon hack than anything else.
Controlling the video output using the BT869 should really be up to the
video driver (framebuffer or X) and not to the user.

-- 
Jean Delvare
