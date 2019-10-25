From: Wei Hu <weh@microsoft.com>
Date: Fri, 25 Oct 2019 08:09:34 +0000
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
Message-Id: <PU1P153MB0169EA21993B5893EA7569FABB650@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191022110905.4032-1-weh@microsoft.com>
	<20191023091037.GB21910@lst.de>
In-Reply-To: <20191023091037.GB21910-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
Cc: "sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "info-EcKl7qYKIbxeoWH0uzbU5w@public.gmane.org" <info-EcKl7qYKIbxeoWH0uzbU5w@public.gmane.org>, "alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org" <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org" <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-hyperv-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hyperv-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Kelley <mikelley-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "mchehab+samsung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mchehab+samsung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, KY

VGhhbmtzIGZvciB0aGUgcmV2aWV3LiBQbGVhc2Ugc2VlIG15IHJlc3BvbnNlIGlubGluZS4NCg0K
PiA+ICsJc2VsZWN0IERNQV9DTUENCj4gDQo+IFRo0ZZzIG5lZWRzIHRvIGJlDQo+IA0KPiAJc2Vs
ZWN0IERNQV9DTUEgaWYgSEFWRV9ETUFfQ09OVElHVU9VUw0KPiANCj4gPiArI2luY2x1ZGUgPGxp
bnV4L2RtYS1jb250aWd1b3VzLmg+DQo+IA0KPiA+ICsJLyogQWxsb2NhdGUgZnJvbSBDTUEgKi8N
Cj4gPiArCS8vIHJlcXVlc3RfcGFnZXMgPSAocmVxdWVzdF9zaXplID4+IFBBR0VfU0hJRlQpICsg
MTsNCj4gPiArCXJlcXVlc3RfcGFnZXMgPSAocm91bmRfdXAocmVxdWVzdF9zaXplLCBQQUdFX1NJ
WkUpID4+IFBBR0VfU0hJRlQpOw0KPiA+ICsJcGFnZSA9IGRtYV9hbGxvY19mcm9tX2NvbnRpZ3Vv
dXMoTlVMTCwgcmVxdWVzdF9wYWdlcywgMCwgZmFsc2UpOw0KPiANCj4gZG1hX2FsbG9jX2Zyb21f
Y29udGlndW91cyBpcyBhbiBpbnRlcm5hbCBoZWxwZXIsIHlvdSBtdXN0IHVzZSBpdA0KPiB0aHJv
dWdoIGRtYV9hbGxvY19jb2hlcmVudCBhbmQgcGFzcyBhIHN0cnVjdCBkZXZpY2UgdG8gdGhhdCBm
dW5jdGlvbi4NCj4gDQoNCkNhbiBJIGRpcmVjdGx5IHVzZSBjbWFfYWxsb2MoKSBhbmQgY21hX3Jl
bGVhc2UoKSBpbiB0aGlzIGNhc2U/IFRoZSBjb250aWd1b3VzDQptZW1vcnkgYWxsb2NhdGVkIGlz
IGp1c3QgZm9yIHZpcnR1YWwgZnJhbWVidWZmZXIgZGV2aWNlLCBub3QgZm9yIGFueSBETUENCm9w
ZXJhdGlvbi4gSSB0aGluayB1c2luZyBkbWFfYWxsb2NfY29oZXJlbnQoKSBtaWdodCBiZSBhIGJp
dCBvZiBvdmVya2lsbC4NCg0KPiA+ICsJaWYgKCFnZW4ydm0pIHsNCj4gPiArCQlwZGV2ID0gcGNp
X2dldF9kZXZpY2UoUENJX1ZFTkRPUl9JRF9NSUNST1NPRlQsDQo+ID4gKwkJCVBDSV9ERVZJQ0Vf
SURfSFlQRVJWX1ZJREVPLCBOVUxMKTsNCj4gPiArCQlpZiAoIXBkZXYpIHsNCj4gPiArCQkJcHJf
ZXJyKCJVbmFibGUgdG8gZmluZCBQQ0kgSHlwZXItViB2aWRlb1xuIik7DQo+ID4gKwkJCXJldHVy
biAtRU5PREVWOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gDQo+IFBsZWFzZSBhY3R1YWxseSBpbXBs
ZW1lbnQgYSBwY2lfZHJpdmVyIGluc3RlYWQgb2YgaGFja3MgbGlrZSB0aGlzLg0KPiANCg0KSSBk
b24ndCBxdWl0ZSBmb2xsb3cgdGhpcy4gV2hhdCBkbyB5b3UgbWVhbiBpbXBsZW1lbnRpbmcgYSBw
Y2lfZHJpdmVyDQppbiB0aGlzIGNhc2U/DQoNCj4gPiArCQkJcGFyLT5uZWVkX2RvY29weSA9IGZh
bHNlOw0KPiA+ICsJCQlnb3RvIGdldG1lbTE7DQo+ID4gKwkJfSBlbHNlIHsNCj4gDQo+IE5vIG5l
ZWQgZm9yIGFuIGVsc2UgYWZ0ZXIgYSBnb3RvLg0KVGhhbmtzLiBXaWxsIGRvLg0KDQpXZWkNCg=
