From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.10-rc1-mm2: intelfb/AGP unknown symbols
Date: Sat, 30 Oct 2004 10:28:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1099124920.2822.3.camel@laptop.fenrus.org>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
	 <20041030032425.GI6677@stusta.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263657AbUJ3Ifc@vger.kernel.org>
In-Reply-To: <20041030032425.GI6677@stusta.de>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


> The removal of 3 "unneeded exports" in bk-agpgart.patch conflicts with 
> code adding usage of them in Linus' tree:

that makes me really really curious why the fb driver calls into the backend and not just the agp frontend layer like the rest of the world does...
