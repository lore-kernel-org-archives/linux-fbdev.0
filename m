From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] fbdev: uvesafb
Date: Sat, 23 Jun 2007 14:04:09 +0200
Message-ID: <200706231404.09344.arnd@arndb.de>
References: <20070623104920.GA12623@spock.one.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756178AbXFWMEa@vger.kernel.org>
In-Reply-To: <20070623104920.GA12623@spock.one.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: spock@gentoo.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Saturday 23 June 2007, Michal Januszewski wrote:
> =C2=A0The current implementation of v86d can use either LRMI or
> x86emu to run the BIOS code and supports both x86 and x86_64.

Is there a fundamental reason why you can't also run it on
non-x86 machines, or has this simply not been tested so far?

	Arnd <><
