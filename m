From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 2.4.20-rc1
Date: 08 Nov 2002 17:34:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1036773258.8907.90.camel@zion>
References: <Pine.LNX.4.44L.0211061033410.27268-100000@freak.distro.conectiva>
	<3DCAAF2D.2040202@gmx.net>  <3DCBAC99.7010909@gmx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3DCBAC99.7010909@gmx.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 2002-11-08 at 13:22, Carl-Daniel Hailfinger wrote:

> I managed to trim down the offending patch further. Reverting the new 
> attached patch is enough to fix my problem. Can someone of the framebuffer 
> experts please comment on this one?

Ok, I'm the one to blame for that patch.

It was intended to fix some problems where the console subsystem
would call fbcon_blank after the fbdev HW was put to suspend, thus
crashing the system.

This should really be fixed in the low level fb drivers to ignore
blanking when they are asleep though. This is a kind of hack as 2.4
lacks a proper model for ordering power management requests

Marcelo, feel free to delete those 4 lines (but not the whole patch),
just the 4 lines in fbcon_blank, I'll make sure the various drivers
are made safe.

Ben.
