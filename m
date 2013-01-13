From: Alexander Holler <holler@ahsoftware.de>
Date: Sun, 13 Jan 2013 12:24:30 +0000
Subject: Re: [PATCH] fb: udlfb: fix hang at disconnect
Message-Id: <50F2A77E.1090900@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1357996822-13072-1-git-send-email-holler@ahsoftware.de> <CAF1V4O8UUgWB1XbS=3EsirBjhP9Lp7JQ8XK8MQxbe3ZkH8pd3Q@mail.gmail.com> <50F2A310.5010006@ahsoftware.de>
In-Reply-To: <50F2A310.5010006@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bernie Thompson <bernie@plugable.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Glendinning <steve.glendinning@shawell.net>, Dave Airlie <airlied@redhat.com>, stable@vger.kernel.org

Am 13.01.2013 13:05, schrieb Alexander Holler:
> Am 12.01.2013 23:22, schrieb Bernie Thompson:

> I didn't test it extensively, but without the patch the driver isn't
> usable here. Maybe my previous patch which moves damages to a workqueue

To add some more explanations, I'm currently only testing it with a 
statically linked udlfb (for fbcon) as that is what I'm mainly using the 
device for (with otherwise headless boxes). When udlfb is a module, I 
don't see those "schedule while atomic" messages (I don't know why), but 
having a console only after the modules got loaded isn't always an option.

Regards,

Alexander
