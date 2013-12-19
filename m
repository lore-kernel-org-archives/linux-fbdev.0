From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Date: Thu, 19 Dec 2013 00:03:46 +0000
Subject: Re: cirrusdrmfb broken with simplefb
Message-Id: <20131219000346.0f722b65@alan.etchedpixels.co.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <s5hlhzik3kk.wl%tiwai@suse.de>
	<CANq1E4TFKDduy71jCXy+8CMS1_OFxWEpsHY3AA0RUJPW4VE8hg@mail.gmail.com>
	<20131218092941.GA19210@gmail.com>
In-Reply-To: <20131218092941.GA19210@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: David Herrmann <dh.herrmann@gmail.com>, Takashi Iwai <tiwai@suse.de>, Stephen Warren <swarren@wwwdotorg.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

> > That bug always existed, simplefb is just the first driver to hit it 
> > (vesafb/efifb didn't use resources). I'm aware of the issue but as a 
> > workaround you can simply disable CONFIG_X86_SYSFB. That restores 
> > the old behavior.
> 
> This looks like a regression, so we'll either need a fix or we'll have 
> to mark CONFIG_X86_SYSFB as CONFIG_BROKEN.

Kernel bugzilla has entries for simplefb breaking both vesafb and matrox
mga.


