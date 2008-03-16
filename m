From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] i810fb: Fix console switch regression
Date: Sun, 16 Mar 2008 17:02:21 -0300
Message-ID: <20080316200221.GC31782@khazad-dum.debian.net>
References: <200803161942.24555.stefan.bauer@cs.tu-chemnitz.de> <20080316195722.GB31782@khazad-dum.debian.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753946AbYCPUCd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080316195722.GB31782@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>

On Sun, 16 Mar 2008, Henrique de Moraes Holschuh wrote:
> Might I suggest using "((!par->dev_flags) & LOCKUP)"?

Never mind, I read your other post about that line not even making any
sense the way it was written.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
