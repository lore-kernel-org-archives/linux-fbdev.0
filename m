From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.10-rc1-mm2: intelfb/AGP unknown
	symbols
Date: Sat, 30 Oct 2004 13:34:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1099136087.3883.0.camel@laptop.fenrus.org>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
	 <20041030032425.GI6677@stusta.de>
	 <1099124920.2822.3.camel@laptop.fenrus.org>
	 <200410301921.34961.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263703AbUJ3LhA@vger.kernel.org>
In-Reply-To: <200410301921.34961.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, linux-kernel@vger.kernel.org


> 
> What's wrong with exporting the symbols back again?

if they are the right api to use; nothing. If they aren't (and what you
describe somehow suggests they aren't) it sounds better to make the
frontend usable for the intelfb driver instead...
