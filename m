From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Sun, 6 Mar 2005 10:52:49 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0503061047590.3733@poirot.grange>
References: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jim.hague@acm.org
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

I wasn't quite correct in my report yesterday. Replacing pm2fb.c from 
2.6.11 with 2.6.10 fixes only one problem - the font becomes white again 
and penguin images get fixed. But switching from X to vt still doesn't 
work. It works under 2.6.10-rc2. The new config is based on oldconfig with 
almost all new defaults. Nothing fb-related, AFAICT. I'll try to revert 
some other files in drivers/video later today, unless someone has a better 
idea.

Thanks
Guennadi
---
Guennadi Liakhovetski
