From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Wed, 9 Mar 2005 20:11:03 +0100
Message-ID: <20050309191103.GA632@openzaurus.ucw.cz>
References: <20050308021706.GH26249@spock.one.pl>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20050308021706.GH26249@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Januszewski <spock@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi!

> +The userspace helper
> +--------------------
> +
> +The userspace splash helper (by default: /sbin/splash_helper) is called by the
> +kernel whenever an important event occurs and the kernel needs some kind of
> +job to be carried out. Important events include console switches and graphic
> +mode switches (the kernel requests background images and configuration
> +parameters for the current console). The splash helper must be accessible at 
> +all times. If it's not, fbsplash will be switched off automatically.

Ugh, is not calling userspace when switching consoles deadlock-prone?
What if that helper tries to do printf()?

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
