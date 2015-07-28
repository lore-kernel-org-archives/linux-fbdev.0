From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Date: Tue, 28 Jul 2015 11:56:02 +0000
Subject: Re: omapdss: Division by zero in kernel
Message-Id: <20150728115602.GL13765@pali>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201507241803.42891@pali>
In-Reply-To: <201507241803.42891@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

On Friday 24 July 2015 18:03:42 Pali Rohár wrote:
> Hello,
> 
> when on N900 (real HW or qemu) I run this command
> 
> / # echo 0 > /sys/devices/platform/omapdss/overlay0/enabled && echo 0 > /sys/class/graphics/fb0/size
> 
> then kernel crash with this error message
> 
> / # [   29.904113] Division by zero in kernel.
> ** 3375 printk messages dropped ** [   29.963836] [<c01e0008>] (__aeabi_uidivmod) from [<c022071c>] 
> (cfb_imageblit+0xac/0x464)
> ** 8426 printk messages dropped ** [   30.111083] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8380 printk messages dropped ** [   30.258209] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7813 printk messages dropped ** [   30.400054] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7666 printk messages dropped ** [   30.538391] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7687 printk messages dropped ** [   30.676544] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7960 printk messages dropped ** [   30.819915] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8317 printk messages dropped ** [   30.966979] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8590 printk messages dropped ** [   31.122528] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8885 printk messages dropped ** [   31.287658] [<c0218ed0>] (fbcon_scroll) from [<c025af90>] (scrup+0x60/0x128)
> ** 9408 printk messages dropped ** [   31.461425] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 9787 printk messages dropped ** [   31.644287] [<c02187e8>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10081 printk messages dropped ** [   31.833984] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10501 printk messages dropped ** [   32.031066] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10816 printk messages dropped ** [   32.233001] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10900 printk messages dropped ** [   32.440490] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10837 printk messages dropped ** [   32.645233] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10837 printk messages dropped ** [   32.848999] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10837 printk messages dropped ** [   33.053833] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>] 
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10838 printk messages dropped ** [   33.258361] [<c0218ed0>] (fbcon_scroll) from [<c025af90>] (scrup+0x60/0x128)
> 
> I suspect that problem is in omapdss.
> 
> I do not know if size 0 make sense, but Maemo userspace is calling above
> commands and on Nokia's 2.6.28 kernel there is no crash or error message.
> 
> IMHO Division by zero in kernel should not be there even if userspace
> call "incorrect" command.
> 

PING! Any idea what to do with Division by zero in kernel?

-- 
Pali Rohár
pali.rohar@gmail.com
