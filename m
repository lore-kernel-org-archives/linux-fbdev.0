From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 23 Apr 2010 21:09:46 +0000
Subject: Re: [PATCH 09/11] viafb: Do not probe for LVDS/TMDS on OLPC XO-1.5
Message-Id: <20100423150946.3c3046b2@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271614873-5952-1-git-send-email-corbet@lwn.net>
	<1271614873-5952-10-git-send-email-corbet@lwn.net>
	<4BD2098E.70601@gmx.de>
In-Reply-To: <4BD2098E.70601@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

On Fri, 23 Apr 2010 22:56:46 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> I fear your analysis that the #ifdef's are not needed is wrong. At least 
> with this patch applied I get:
> 
> drivers/video/via/hw.c: In function 'init_tmds_chip_info':
> drivers/video/via/hw.c:2043: error: implicit declaration of function 
> 'machine_is_olpc'

No, the problem is the "embarrassing compilation error" I mentioned in
my other mail; it needs "#include <asm/olpc.h>" at the top of the file.

Sorry,

jon
