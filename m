From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.10-rc1-mm2: intelfb/AGP unknown symbols
Date: Sat, 30 Oct 2004 21:08:32 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410302108.32872.adaplas@hotpop.com>
References: <20041029014930.21ed5b9a.akpm@osdl.org> <200410301921.34961.adaplas@hotpop.com> <1099136087.3883.0.camel@laptop.fenrus.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261151AbUJ3NIs@vger.kernel.org>
In-Reply-To: <1099136087.3883.0.camel@laptop.fenrus.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Arjan van de Ven <arjan@infradead.org>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, linux-kernel@vger.kernel.org

On Saturday 30 October 2004 19:34, Arjan van de Ven wrote:
> > What's wrong with exporting the symbols back again?
>
> if they are the right api to use; nothing. If they aren't (and what you
> describe somehow suggests they aren't) it sounds better to make the
> frontend usable for the intelfb driver instead...
>

I think the functions are the right API to use for clients within the
kernel.  The frontend is directed more for userspace clients. 

The old interface was to do an inter_module_get/put, but this is to
be deprecated. And all it does is to provide all the backend functions
to the requestor.

Either  a new interface is provided by agpgart, otherwise, not just intelfb
and i810fb will be affected, but also DRM (which currently uses
inter_module_get/put("drm_agp")).

If I remember correctly, the DRI people also have a new patch that removes
inter_module_get/put and they did it by calling the backend functions directly.

Tony
