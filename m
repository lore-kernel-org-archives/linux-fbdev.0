From: James Simmons <jsimmons@infradead.org>
Subject: Re: FBDEV updates.
Date: Thu, 14 Aug 2003 21:52:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0308142150390.15200-100000@phoenix.infradead.org>
References: <20030814203658.GE7862@guug.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030814203658.GE7862@guug.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Otto Solares <solca@guug.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> what is the current state of PM in fb drivers?

Experinmental patch from Ben is in the works.

> does modedb is being used on 2.6 drivers?

Yes. 

> Is there an API (or lib) to use framebuffers devices without
> worring about differents visuals?, 

??? 

> to quering, setting or
> disabling EDID support? 

Yes. That is the fbmon.c stuff. Still needs work. 

> will these drivers export sysfs
> entries instead of control via ioctl's?

Needs to be done. I'm not familiar with sysfs so it hasn't been done.


> thanks for your work on fb.

Your welcome. 
