From: joeyli <jlee@suse.com>
Date: Thu, 22 Mar 2012 01:33:57 +0000
Subject: Re: [PATCH] Added backlight driver for Acer Aspire 4736
Message-Id: <1332380037.10557.398.camel@linux-s257.site>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331608337.2267.67.camel@debian.Gayathri>
	 <20120312175130.GA18002@srcf.ucam.org>
	 <1331640592.3485.50.camel@debian.Gayathri>
	 <20120313124738.GB10822@srcf.ucam.org>
	 <CABNxG=Dqg26EHmC3vibf3-SjVhby1qgQfMniQObUeh9eJ6SwEw@mail.gmail.com>
	 <20120313133458.GA11574@srcf.ucam.org>
	 <1331688294.2577.19.camel@debian.Gayathri>
	 <1331680373.10557.169.camel@linux-s257.site>
	 <1331692996.3052.8.camel@debian.Gayathri>
	 <1331704278.10557.190.camel@linux-s257.site>
	 <CABNxG=D3y2GQqS1XN=+B0QRScXpufBkPQtP5-SSNEjSavhtW7g@mail.gmail.com>
	 <1331798740.10557.245.camel@linux-s257.site>
	 <1332047432.6304.13.camel@debian.Gayathri>
	 <1332122514.10557.270.camel@linux-s257.site>
	 <1332241764.10557.329.camel@linux-s257.site>
	 <1332269710.3921.31.camel@debian.Gayathri>
	 <1332298845.10557.343.camel@linux-s257.site>
	 <1332356993.3103.23.camel@debian.Gayathri>
In-Reply-To: <1332356993.3103.23.camel@debian.Gayathri>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1254"
Content-Transfer-Encoding: base64
To: Pradeep Subrahmanion <subrahmanion.pradeep@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>, rpurdie@rpsys.net, FlorianSchandinat@gmx.de, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

5pa8IOWbm++8jDIwMTItMDMtMjIg5pa8IDAwOjM5ICswNTMw77yMUHJhZGVlcCBTdWJyYWhtYW5p
b24g5o+Q5Yiw77yaCj4gPiBUaGlzIG5ldyBwYXRjaCBzaG91bGQgcmVtb3ZlIGFjcGlfdmlkZW8w
IGludGVyZmFjZSBvbiB5b3VyIG1hY2hpbmUuCj4gPiBQbGVhc2Uga2luZGx5IHByb3ZpZGUgeW91
ciBkbWlkZWNvZGU6Cj4gPiAgZG1pZGVjb2RlID4gZG1pZGVjb2RlLmxvZwo+ID4KPiA+IEFuZCwg
Cj4gPiBwbGVhc2UgbWFrZSBzaG91bGQgdGhlIHBhdGNoIHJlYWxseSBhcHBsaWVkLCB5b3UgY2Fu
IGRvIGEgYml0IGNoYW5nZSBvbgo+ID4gcHJfaW5mbyBtZXNzYWdlIGJ5IHlvdXJzZWxmLgo+IAo+
ICAgIFNvcnJ5IC4gSSB0aGluayB0aGVyZSB3YXMgc29tZSBtaXN0YWtlIC4gSSB0cmllZCB0aGUg
cGF0Y2ggYWdhaW4uIE5vdwo+IEkgc2VlIG9ubHkgaW50ZWxfYmFja2xpZ2h0IGluc2lkZSAvc3lz
L2NsYXNzL2JhY2tsaWdodC4gVGhlcmUgaXMgbm8KPiBhY2VyLXdtaSBpbnRlcmZhY2UgLiBJcyB0
aGlzIHRoZSBleHBlY3RlZCBiZWhhdmlvciA/IC4gT3IgYW0gSSBtaXNzaW5nCj4gYW55dGhpbmcg
Pwo+IAoKWWVzLCB0aGlzIGlzIHRoZSBleHBlY3RlZCBiZWhhdmlvciEgQnV0LCBub3cgSSBkb3Vi
dCB5b3VyIGlzc3VlIHdhcwp3b3JrYXJvdW5kIGJ5IGFjcGlfb3NpPUxpbnV4IGJ1dCBub3QgaW50
ZWxfYmFja2xpZ2h0LgoKPiAKPiAKPiA+IAo+ID4gPiBlY2hvIDUgPiAvc3lzL2NsYXNzL2JhY2ts
aWdodC9hY3BpX3ZpZGVvMC9icmlnaHRuZXNzIAo+ID4gPiBlY2hvIDUgPiAvc3lzL2NsYXNzL2Jh
Y2tsaWdodC9pbnRlbF9iYWNrbGlnaHQvYnJpZ2h0bmVzcwo+ID4gPiAKPiA+ID4gQnV0IGl0IGRv
ZXNuJ3QgbWFrZSBhbnkgY2hhbmdlIC4gCj4gPiA+IAo+ID4gPiBJbiBteSBjYXNlICAsICdhY3Bp
X2JhY2tsaWdodCA9IHZlbmRvcicgZG9lcyBub3QgbWFrZSBhbnkgZGlmZmVyZW5jZSBzaW5jZSB0
aGUgaG90IGtleSBjb250cm9sIAo+ID4gPiAKPiA+ID4gYWxyZWFkeSBzdGFydHMgd29ya2luZyB3
aXRoICdhY3BpX29zaT1MaW51eCcgb3B0aW9uLgo+ID4gPiAKPiA+ID4gY2F0IC9wcm9jL2NtZGxp
bmUgZ2l2ZXMgLCAKPiA+ID4gCj4gPiA+IEJPT1RfSU1BR0U9L2Jvb3Qvdm1saW51ei0zLjMuMCsK
PiA+ID4gcm9vdD1VVUlE8DE5N2E1OS1jMDY3LTRmZDgtYWQ5MC1jNGQ3MjE4MTYwNzcgcm8gYWNw
aV9vc2k9TGludXggCj4gPiA+IAo+ID4gPiAKPiA+ID4gVGhhbmtzICwgCj4gPiA+IAo+ID4gPiBQ
cmFkZWVwIFN1YnJhaG1hbmlvbgo+ID4gPiAKPiA+IAo+ID4gT0ssIHRoYXQncyBtb3JlIGNsZWFy
bHksIHBsZWFzZSByZW1vdmUgYWNwaV9vc2k9TGludXggdGhlbiByZS10ZXN0LCBJCj4gPiB0aGlu
ayB0aGUgaG90a2V5IG9mIGJhY2tsaWdodCBjb250cm9sIG9ubHkgd29ya3Mgd2l0aCBhY3BpX29z
aT1MaW51eCA/Cj4gPiAKCkRvZXMgeW91ciBiYWNrbGlnaHQgY29udHJvbCBzdGlsbCB3b3JrIGlm
IHlvdSByZW1vdmUgYWNwaV9vc2k9TGludXggPwoKClRoYW5rcyBhIGxvdCEKSm9leSBMZWUKCi0t
ClRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmli
ZSBsaW51eC1mYmRldiIgaW4KdGhlIGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2Vy
Lmtlcm5lbC5vcmcKTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9y
Zy9tYWpvcmRvbW8taW5mby5odG1s
