From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Cbe-oss-dev] [PATCH 04/15] ps3vram: Replace mutex by spinlock + list
Date: Sun, 10 May 2009 21:05:05 +0200
Message-ID: <20090510190505.GA23535@lst.de>
References: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com> <1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com> <1241791284-11490-3-git-send-email-Geert.Uytterhoeven@sonycom.com> <1241791284-11490-4-git-send-email-Geert.Uytterhoeven@sonycom.com> <1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752724AbZEJTFd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, Jim Paris <jim@jtan.com>, linux-kernel@vger.kernel.org

On Fri, May 08, 2009 at 04:01:13PM +0200, Geert Uytterhoeven wrote:
> Remove the mutex serializing access to the cache.
> Instead, queue up new requests on a list if the driver is busy.

This should use the bio list helpers moved into bio.h in commit
8f3d8ba20e67991b531e9c0227dcd1f99271a32c
