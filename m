From: Jonathan Corbet <corbet@lwn.net>
Date: Mon, 20 Sep 2010 12:43:54 +0000
Subject: Re: [PATCH 05/12] viafb: fix i2c_transfer error handling
Message-Id: <20100920064354.2fc28219@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1284879532.git.FlorianSchandinat@gmx.de>
	<171e0fb74a34b069c0c12aa90c56d5e5da5489c6.1284879532.git.FlorianSchandinat@gmx.de>
In-Reply-To: <171e0fb74a34b069c0c12aa90c56d5e5da5489c6.1284879532.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Joseph Chan <JosephChan@via.com.tw>

On Sun, 19 Sep 2010 07:33:46 +0000
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> i2c_transfer returns negative errno on error and number of messages
> processed on success. Just returning this value would give a poor
> interface as it is not obvious that you must compare with 2 after reading
> 1 or n bytes and with 1 after writing 1 byte to determine if it was
> successful. To avoid this error prone interface convert the error code
> of a successful read/write to zero and all other non-negative values to
> an negative error code.
> This fixes a regression introduced by
> 	via: Rationalize vt1636 detection
> which resulted in no longer detecting a VT1636 chip and therefore has
> broken the output in configurations wich contain this chip.

From a quick look, all of these patches look like improvements to me.
This one, since it's a regression fix, should probably have a 
Cc: stable@kernel.org in it as well.

Acked-by: Jonathan Corbet <corbet@lwn.net>

jon
