From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 2.6.20 1/1] fbdev,mm: hecuba/E-Ink fbdev driver
Date: Sat, 17 Feb 2007 13:34:12 +0100
Message-ID: <1171715652.5186.7.camel@lappy>
References: <20070217104215.GB25512@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965219AbXBQMeS@vger.kernel.org>
In-Reply-To: <20070217104215.GB25512@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On Sat, 2007-02-17 at 11:42 +0100, Jaya Kumar wrote:
> Hi James, Geert, lkml and mm,

Hi Jaya,

> This patch adds support for the Hecuba/E-Ink display with deferred IO.
> The changes from the previous version are to switch to using a mutex
> and lock_page. I welcome your feedback and advice.

This changelog ought to be a little more extensive; esp. because you're
using these fancy new functions ->page_mkwrite() and page_mkclean() in a
novel way.

Also, I'd still like to see a way to call msync() on the mmap'ed region
to force a flush. I think providing a fb_fsync() method in fbmem.c and a
hook down to the driver ought to work.

Also, you now seem to use a fixed 1 second delay, perhaps provide an
ioctl or something to customize this?

And, as Andrew suggested last time around, could you perhaps push this
fancy new idea into the FB layer so that more drivers can make us of it?
