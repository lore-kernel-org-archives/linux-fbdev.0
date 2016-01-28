From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Date: Thu, 28 Jan 2016 14:20:37 +0000
Subject: Re: Whats missing in my new FB DRM driver in ARC... waiting for console_lock to return
Message-Id: <1453990837.4304.15.camel@synopsys.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5684268E.2000607@synopsys.com>
 <CAGd==071hzpQKjLU715tc004NN0d8Z01XdLAhg-DBx1FxtWb2w@mail.gmail.com>
 <569CF78F.7050303@synopsys.com> <569CFA9B.4060108@synopsys.com>
 <CAGd==07ffJAfAtzirALR3OF7f4UDVu_fJbbZ0ZiEa3F5-hLfyw@mail.gmail.com>
 <569E5E51.8000303@synopsys.com> <569E69EB.3010003@synopsys.com>
 <CAGd==04VMKUvb6hZkeNw3kAQt04y0d_Ry7oCtC8=2SWcfWG25A@mail.gmail.com>
 <56A11EF1.3070004@synopsys.com> <56A123CD.1060706@synopsys.com>
In-Reply-To: <56A123CD.1060706@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "xinliang.liu@linaro.org" <xinliang.liu@linaro.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>

SGkgQ2FybG9zLA0KDQpPbiBUaHUsIDIwMTYtMDEtMjEgYXQgMTg6MzAgKzAwMDAsIENhcmxvcyBQ
YWxtaW5oYSB3cm90ZToNCj4gaGkuLi4NCj4gDQo+IGkganVzdCBmb3VuZCB0aGF0IGl0cyBibG9j
a2luZyB3YWl0aW5nIGZvciBjb25zb2xlX2xvY2suLi4NCj4gQHZpbmVldCwgYWxleGV5OiBpIHRo
aW5rIHRoYXQgY29uc29sZV9sb2NrIGlzIGFyY2hpdGVjdHVyZSBkZXBlbmRlbnQgcmlnaHQ/IERv
IHlvdSBrbm93IGFueSBpc3N1ZSB3aXRoIGNvbnNvbGVfbG9jaw0KPiBmb3IgQVJDPw0KDQpJJ20g
bm90IHJlYWxseSBzdXJlICJjb25zb2xlX2xvY2siIGhhcyBzb21ldGhpbmcgdG8gZG8gd2l0aCBB
UkMgYXJjaGl0ZWN0dXJlLg0KQXQgbGVhc3QgImdpdCBncmVwIGJjb25zb2xlX2xvY2siIGRvZXNu
J3QgZmluZCBhbnl0aGluZyBpbiAiYXJjaC9hcmMiLg0KDQpTbyBJJ2QgYXNzdW1lIHRoaXMgaXMg
YSBnZW5lcmljIHRoaW5nLg0KDQotQWxleGV5
