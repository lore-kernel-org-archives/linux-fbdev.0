From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 15 Sep 2011 21:31:24 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <20110915223124.7c24e6bb@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com> <4E72320B.6020000@gmx.de>
	<20110915181802.69ef0d56@lxorguk.ukuu.org.uk>
	<4E723A20.2040002@gmx.de>
	<20110915200514.74bdcd90@lxorguk.ukuu.org.uk>
	<4E72561C.7060603@gmx.de>
In-Reply-To: <4E72561C.7060603@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linaro-dev@lists.linaro.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

> Okay, I see your problem. It's a bit strange you don't have acceleration. I

The hardware has 3D acceleration but not open so we can't support it.
There is no 2D acceleration - which seems to be increasingly common.

At some point I'll add hardware scrolling however by using the GTT to
implemnent scroll wrapping.

> sound like a big problem to me, but pretty inefficient, so probably copying the
> existing ones and adjusting it to your needs would be preferred (just like the
> sys* implementations exist).

I did have a look at the current ones but fixing them up given scan lines
can span page boundaries looked pretty horrible so I deferred it until I
feel inspired.

Alan
