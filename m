From: Richard Drummond <lists@rcdrummond.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] Big-endian fixes for tdfxfb in 2.4.21
Date: Sat, 19 Jul 2003 04:34:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200307190434.08829.lists@rcdrummond.net>
References: <200307190131.46394.lists@rcdrummond.net>
Reply-To: lists@rcdrummond.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200307190131.46394.lists@rcdrummond.net>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Saturday 19 July 2003 01:39 am, Richard Drummond wrote:
> I've tested this patch extensively both on a Voodoo3 and a Voodoo4 . . .

Ooops. I apologize. It turns out that I didn't test this as thoroughly as I 
had thought. Although the Voodoo3 works perfectly, 16-bit and 32-bit modes  
are still broken on the Voodoo4.

Does anybody have docs on the Voodoo4/5 or know how byte-swizzling woks on 
these cards? It definitely doesn't behave the same as the Voodoo3 . . .

If nobody objects, the patch I posted previously should still be applied to 
2.4 since it does fix all the endian problems in tdfxfb with the Voodoo3.

Cheers,
Rich
