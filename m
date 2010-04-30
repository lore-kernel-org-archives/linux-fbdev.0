From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 30 Apr 2010 15:39:24 +0000
Subject: Re: [RFC] Second OLPC Viafb series, v2
Message-Id: <20100430093924.3d92fa59@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>
	<20100429192613.5385c501@neptune.home>
In-Reply-To: <20100429192613.5385c501@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?ISO-8859-1?B?UHLpbW9udA==?= <bonbons@linux-vserver.org>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Thu, 29 Apr 2010 19:26:13 +0200
Bruno Pr=E9mont <bonbons@linux-vserver.org> wrote:

> Testing here, loading path seems to work fine (console mode) as well as
> mode switching with fbset, but rmmod viafb fails with below trace.

OK, it looks like gpiochip_remove() is not meant to be called with IRQs
disabled.  That's easily fixed.  Thanks for testing!

jon
