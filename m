From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add CONFIG_FB_PRE_INIT_FB option to VT and fbcon
Date: Thu, 23 Apr 2009 22:06:22 +0100
Message-ID: <20090423220622.313090a1@lxorguk.ukuu.org.uk>
References: <1240348380-15674-1-git-send-email-agust@denx.de>
	<20090423134952.5328923a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759078AbZDWVHm@vger.kernel.org>
In-Reply-To: <20090423134952.5328923a.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Anatolij Gustschin <agust@denx.de>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

This looks to be a complete mess. It puts a large pile of ifdefs all over
core kernel code for a single hack specific to one environment.

If you don't want the vt layer using the frame buffer then don't use the
vt layer.

Alan
