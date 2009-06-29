From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Framebuffer support for HTC Dream
Date: Mon, 29 Jun 2009 12:41:32 -0700
Message-ID: <20090629124132.e84e3d21.akpm@linux-foundation.org>
References: <20090629111029.GA15514@elf.ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759386AbZF2TmK@vger.kernel.org>
In-Reply-To: <20090629111029.GA15514@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, swetland@google.com

On Mon, 29 Jun 2009 13:10:30 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> I cleaned up dead code, a lot of debugging infastructure and horrific
> logo code. I had to remove earlysuspend support, because neccessary
> headers are not in mainline. The driver still works :-).

The patch still generates a world-record amount of checkpatch output,
quite a lot of which could be safely ignored, but some of which we
should fix?
