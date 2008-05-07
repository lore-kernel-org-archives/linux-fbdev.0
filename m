From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Linux-fbdev-devel] [PATCH 2/9] viafb: VIA Frame Buffer Device
 Driver
Date: Wed, 7 May 2008 16:30:15 +0100
Message-ID: <20080507163015.3e1c9abf@core>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67753@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764206AbYEGPlF@vger.kernel.org>
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67753@exchtp03.taipei.via.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Cc: JosephChan@via.com.tw, akpm@linux-foundation.org, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


>
> +u16 red256[] = {

Asking for clashes again - naming issues.

Also stuff that cannot be changed is best marked const.
