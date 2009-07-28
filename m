From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] viafb: fix rmmod bug
Date: Tue, 28 Jul 2009 14:34:08 -0700
Message-ID: <20090728143408.b1b6dba0.akpm@linux-foundation.org>
References: <1248538728-27344-1-git-send-email-FlorianSchandinat@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755357AbZG1VeZ@vger.kernel.org>
In-Reply-To: <1248538728-27344-1-git-send-email-FlorianSchandinat@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, FlorianSchandinat@gmx.de, Scott Fang <ScottFang@viatech.com.cn>, Joseph Chan <JosephChan@via.com.tw>

(maintainers cc'ed)

On Sat, 25 Jul 2009 16:18:48 +0000
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> This fixes a bug caused by changing pointers (viafb_mode, viafb_mode1)
> assigned by module_param. It reduces driver complexity by not needlessly
> changing these vars as they are only read once and removing now
> superfluous code.

Can you please provide a better description of this bug?  What user
action triggers it, what effect is observed, what code defect caused
it, how the patch fixes it, etc?

Thanks.
