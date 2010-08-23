From: Jonathan Corbet <corbet@lwn.net>
Date: Mon, 23 Aug 2010 12:42:33 +0000
Subject: Re: [PATCH 1/2] drivers/video: Removing dead FB_VIA_CAMERA config
Message-Id: <20100823064233.51889684@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1282554255.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<896537c6f9bd2e4babcb9ff4681bb4db72daf544.1282554255.git.qy03fugy@stud.informatik.uni-erlangen.de>
In-Reply-To: <896537c6f9bd2e4babcb9ff4681bb4db72daf544.1282554255.git.qy03fugy@stud.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Cc: Joseph Chan <JosephChan@via.com.tw>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, Erik-Jan Post <ej.lfs@xs4all.nl>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, vamos-dev@i4.informatik.uni-erlangen.de

On Mon, 23 Aug 2010 11:59:41 +0200
Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de> wrote:

> CONFIG_FB_VIA_CAMERA doesn't exist in Kconfig, therefore removing
> all references to it from the source.

The driver using this option has been posted to the lists a few times.
I have been unforgivably slow in dealing with some review comments, and
so missed the 2.6.36 merge window.  I don't plan to let that happen
again, though.  So my preference would be to leave this code in place;
if it goes away, I'll just have to put it back.

Thanks,

jon
