From: Paul Mackerras <paulus@samba.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fix controlfb and platinumfb drivers
Date: Wed, 28 May 2003 09:08:12 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <16083.61404.354044.232004@nanango.paulus.ozlabs.org>
References: <16079.23061.979768.135318@argo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0305272328300.26160-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305272328300.26160-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

James Simmons writes:

> Applied. Tho it is strnage. You shouldn't need to call fb_set_var from the 
> driver. 

It's just convenient to use fb_set_var to get the hardware set to the
initial mode.  Would it be better to call controlfb_check_var,
controlfb_set_par, etc., directly?

Paul.
