From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 03 Sep 2011 10:25:42 +0000
Subject: Re: [PATCH 2/2] vt: dirty hack
Message-Id: <20110903112542.5d3cbfcc@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315013361-3191-1-git-send-email-FlorianSchandinat@gmx.de>
	<1315013361-3191-3-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1315013361-3191-3-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Dave Airlie <airlied@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Bernie Thompson <bernie@plugable.com>, Martin Decky <martin@decky.cz>

On Sat,  3 Sep 2011 01:29:21 +0000
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

All of the vt stuff wants doing properly not as hacks.

I think the fundamental change you need is to instroduce some sort of
vc->group pointer and vc group object that holds all the globals in the
vt layer for each group (ie move fg_console, console_blanked etc).

That can be done in steps, and once done you can then start to use
vc->group-> within the fbcon driver and possibly also have a per fb
group data attached to vc->group->fb or similar.

Hacks are fine for early prototyping but doing it right means thinking
about the data structures you ultimately need so that existing systems
work, multi-monitor continues to work and you can do proper multi-console
stuff.

I'm all for it happening done right, and some things like being able to
attach an fb console to arbitary GEM objects would allow very nice
integration of the console into things like Wayland.

Alan
