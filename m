From: "Michal Januszewski" <michalj@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] drivers: process failure of sysfs_create_group()
Date: Tue, 11 Nov 2008 11:05:15 +0100
Message-ID: <5d9b736f0811110205q719ad246t81cc00fd9997b10@mail.gmail.com>
References: <20081110105332.GA19358@ubuntu>
	 <Pine.LNX.4.64.0811102229170.19341@anakin>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755361AbYKKKFl@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0811102229170.19341@anakin>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jianjun Kong <jianjun@zeuux.org>, linux-fbdev-devel@lists.sourceforge.net, Linux-Kernel-Mailing-List <linux-kernel@vger.kernel.org>

On Mon, Nov 10, 2008 at 22:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>> When fail to call sysfs_create_group(), it should recycle resources and return the error.
>> This patch fix for processing failure of sysfs_create_group().
>
> IIRC, the reasoning behind the current code is that a failure to create sysfs
> entries is not critical, as it doesn't impact the correct functioning of the
> core of the driver.

That's correct -- that was exactly my reasoning behind this code.

-- 
Michal Januszewski, Gentoo Linux Developer
http://people.gentoo.org/spock
