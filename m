From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 23 Apr 2010 21:57:25 +0000
Subject: Re: [PATCH 10/11] viafb: rework the I2C support in the VIA
Message-Id: <20100423155725.7d3b2d2d@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271614873-5952-1-git-send-email-corbet@lwn.net>
	<1271614873-5952-11-git-send-email-corbet@lwn.net>
	<4BD20D56.7080402@gmx.de>
In-Reply-To: <4BD20D56.7080402@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

On Fri, 23 Apr 2010 23:12:54 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> 1. while the module loads the screen shows some strange colours. The 
> colours itself do not worry me but it probably at least means that the 
> module load time was increased significantly (2-3 seconds, I guess)
> 
> 2. most annoyingly after this patch I can no longer get a working VGA 
> console after unbinding the module. Normally I just do:

Hmm...compiling the driver as a module is not really something that
makes sense on the OLPC platform, so I've never done it.

#1 is weird, there should be nothing there that slows initialization
down.  Putting in some prints and looking at the timing would be most
helpful here.

As for #2, I can certainly say that I've never unloaded this code, so
that's an untested path.  I'll have a look and see if I can see
anything obvious.

jon
