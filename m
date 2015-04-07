From: Marek Vasut <marex@denx.de>
Date: Tue, 07 Apr 2015 14:24:45 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <201504071624.45410.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd> <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tuesday, April 07, 2015 at 02:19:33 PM, Geert Uytterhoeven wrote:
> Hi Pavel,
> 
> On Tue, Apr 7, 2015 at 2:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > I have an socfpga board, which uses has simple framebuffer implemented
> > in the FPGA. On 3.15, framebuffer is fast:
> > 
> > root@wagabuibui:~# time cat /dev/fb0 > /dev/null
> > real               0m 0.00s
> > user               0m 0.00s
> > sys                0m 0.00s
> > 
> > on 3.18, this takes 220msec. Similar slowdown exists for
> > writes. Simple framebuffer did not change at all between 3.15 and
> > 3.18; resource flags of the framebuffer are still same (0x200).
> > 
> > If I enable caching on 3.18, it speeds up a bit, to 70msec or
> > so... Which means problem is not only in caching.
> > 
> > Any ideas?
> 
> My first guess was  commit 67dc0d4758e5 ("vt_buffer: drop console buffer
> copying optimisations"), but this was introduced only in v4.0-rc1.
> 
> Just in case you encounter another performance regression after upgrading
> to a more modern kernel ;-)

Why don't you use the Altera VIP FB on SoCFPGA ?

Best regards,
Marek Vasut
