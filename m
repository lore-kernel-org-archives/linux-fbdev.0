From: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [PATCH] Framebuffer mode required for PowerBook Titanium
Date: Sun, 6 Nov 2005 01:30:19 +0100
Message-ID: <20051106003019.GA19508@hansmi.ch>
References: <20051105234938.GA18608@hansmi.ch> <436D4A36.70606@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932231AbVKFAaW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <436D4A36.70606@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

> Does booting with video=xxxfb:1152x768M@60 work?  If it does, I would prefer
> that we avoid adding more entries to the global mode database.

It boots but the picture is stretched over the display. That's what I
first tried, too, but only adding the mode definition fixed it.

Greets,
Michael
