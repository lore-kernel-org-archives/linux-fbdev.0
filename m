From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] tdfxfb: move I2C functionality into the tdfxfb
Date: Tue, 24 Mar 2009 08:58:39 +0100
Message-ID: <20090324085839.43a6b496@hyperion.delvare>
References: <20090323192637.b820f669.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090323192637.b820f669.krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On Mon, 23 Mar 2009 19:26:37 +0100, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
> 
> The I2C functionality provided by the i2c-voodoo3 driver
> is moved into the tdfxfb (frame buffer driver for Voodoo3
> cards). This way there is no conflict between the i2c driver
> and the fb driver.
> 
> The tdfxfb does not make use from the DDC functionality yet
> but provides all the functionality of the i2c-voodoo3 driver.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

> ---
> I prefer to send these patches through Andrew Morton's
> tree as the second patch is not related to the i2c stuff.
> 
> Both patches are for the -mm tree.

Fine with me.

> 
>  drivers/video/Kconfig  |    9 ++
>  drivers/video/tdfxfb.c |  200 +++++++++++++++++++++++++++++++++++++++++++++++-
>  include/video/tdfx.h   |   26 ++++++
>  3 files changed, 234 insertions(+), 1 deletions(-)
> 
> (...)

-- 
Jean Delvare
