From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH/RFC 2.6.20 1/2] fbdev, mm: Deferred IO support
Date: Thu, 1 Mar 2007 23:01:31 +0900
Message-ID: <20070301140131.GA6603@linux-sh.org>
References: <20070225051312.17454.80741.sendpatchset@localhost>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965045AbXCAOEF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070225051312.17454.80741.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sun, Feb 25, 2007 at 06:13:12AM +0100, Jaya Kumar wrote:
> This patch implements deferred IO support in fbdev. Deferred IO is a way to
> delay and repurpose IO. This implementation is done using mm's page_mkwrite
> and page_mkclean hooks in order to detect, delay and then rewrite IO. This
> functionality is used by hecubafb.
> 
Any updates on this? If there are no other concerns, it would be nice to
at least get this in to -mm for testing if nothing else.

Jaya, can you roll the fsync() patch in to your defio patch? There's not
much point in keeping them separate.
