From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
Date: Wed, 3 Nov 2004 07:19:04 +0800
Message-ID: <200411030719.06138.adaplas@hotpop.com>
References: <Pine.LNX.4.10.10411022257010.5391-100000@mtfhpc.demon.co.uk>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10411022257010.5391-100000@mtfhpc.demon.co.uk>
Content-Disposition: inline
Sender: sparclinux-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, geert@linux-m68k.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org, wli@holomorphy.com

On Wednesday 03 November 2004 06:57, Mark Fortescue wrote:
> Will this work for a kernel Panic ?
>

Probably not, unless the 'Panic' tells fbcon to release the console and 
tells promcon to take over the console again.  That in itself is problematic
as fbcon cannot be safely unloaded yet.

Tony


