From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] tdfxfb: make use of DDC information about connected
  monitor
Date: Tue, 24 Mar 2009 22:35:28 +0100
Message-ID: <20090324223528.22de9551@hyperion.delvare>
References: <20090323192646.da98a636.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090323192646.da98a636.krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

Hi Krzysztof,

On Mon, 23 Mar 2009 19:26:46 +0100, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
> 
> Read DDC information from a connected monitor
> and use it to select initial mode (if the mode
> is not specified).
> Also, use the information to protect against
> modes outside the monitor specs.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
> ---
>  drivers/video/tdfxfb.c |   67 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 63 insertions(+), 4 deletions(-)

Patch tested successfully. Without the patch:

fb: 3Dfx Voodoo3 memory = 16384K
Console: switching to colour frame buffer device 80x30

With the patch:

fb: 3Dfx Voodoo3 memory = 16384K
Console: switching to colour frame buffer device 128x48

Much better! :) This is on a Voodoo3. If you want me to test something
in particular, just let me know.

Thanks,
-- 
Jean Delvare
