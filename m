From: Paul Mackerras <paulus@samba.org>
Subject: xxx_check_var
Date: Wed, 11 Dec 2002 09:40:10 +1100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <15862.27978.670448.901111@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

When I look at atyfb_check_var or aty128fb_check_var, I see that they
will alter the contents of *info->par.  Isn't this a bad thing?  My
understanding was that after calling check_var, you don't necessarily
call set_par next (particularly if check_var returned an error).
Also I notice that atyfb_set_par and aty128fb_set_par don't look at
info->var, they simply set the hardware state based on the contents of
*info->par.

Looking at skeletonfb.c, it seems that this is the wrong behaviour.  I
had fixed the aty128fb.c driver in the linuxppc-2.5 tree.  James, if
you let me know whether the current behaviour is wrong or not, I'll
fix them and send you the patch.

Paul.
