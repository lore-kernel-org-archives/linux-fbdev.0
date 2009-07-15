From: Harald Welte <HaraldWelte@viatech.com>
Subject: Re: [PATCH] viafb: Don't accelerate blit of color images
Date: Wed, 15 Jul 2009 22:34:49 +0200
Message-ID: <20090715203449.GA11272@prithivi.gnumonks.org>
References: <20090715111127.132C49D405C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@lists.laptop.org>
Content-Disposition: inline
In-Reply-To: <20090715111127.132C49D405C@zog.reactivated.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=unsubscribe>
List-Archive: <http://lists.laptop.org/pipermail/devel>
List-Post: <mailto:devel@lists.laptop.org>
List-Help: <mailto:devel-request@lists.laptop.org?subject=help>
List-Subscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=subscribe>
Sender: devel-bounces@lists.laptop.org
Errors-To: devel-bounces@lists.laptop.org
To: Daniel Drake <dsd@laptop.org>
Cc: JosephChan@via.com.tw, devel@lists.laptop.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, Jul 15, 2009 at 12:11:27PM +0100, Daniel Drake wrote:
> When the Tux boot logo is enabled, the boot penguin does not get rendered
> correctly and under certain circumstances the system will hang.
> 
> This appears to be because the accelerated blitting code only supports
> mono images at the moment, as suggested by a high bit 8 of the GECMD in
> viafb_imageblit().

Thanks, I've applied this to my via-viafb branch of linux-2.6-via.git

-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Free and Open Source Software Liaison
