From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 12 Sep 2013 18:10:16 +0000
Subject: Re: [PATCH 1/2] video: ARM CLCD: Add DT support
Message-Id: <1379009416.13571.68.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378488201-21146-1-git-send-email-pawel.moll@arm.com>
 <522BAED9.4020301@gmail.com> <1378725559.4082.28.camel@hornet>
 <522F91F8.6010207@gmail.com> <1378907036.4082.105.camel@hornet>
 <5230DD1C.6060606@gmail.com> <1378999425.13571.54.camel@hornet>
In-Reply-To: <1378999425.13571.54.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, 2013-09-12 at 16:23 +0100, Pawel Moll wrote:
> Anyway, I think I've got an idea how to render the problem custom panel
> properties invalid. If so, I'll send another version of the patch.

So, instead of describing the panel I thought I'd go lower level and try
to describe the CLCD's signal functions. It gets down to something like
this:

8<----
- arm,pl11x,panel-data-pads: array of 24 cells, each of them describing
				a function of one of the CLD pads,
				starting from 0 up to 23; each pad can
				be described by one of the following values:
	- 0: reserved (not connected)
	- 0x100-0x107: color upper STN panel data 0 to 7
	- 0x110-0x117: color lower STN panel data 0 to 7
	- 0x200-0x207: mono upper STN panel data 0 to 7
	- 0x210-0x217: mono lower STN panel data 0 to 7
	- 0x300-0x307: red component bit 0 to 7 of TFT panel data
	- 0x310-0x317: green component bit 0 to 7 of TFT panel data
	- 0x320-0x327: blue component bit 0 to 7 of TFT panel data
	- 0x330: intensity bit of TFT panel data
				Example set of values for standard
				panel interfaces:
	- PL110 single colour STN panel:
			<0x107 0x106 0x105 0x104 0x103 0x102 0x101 0x100>,
			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
	- PL110 dual colour STN panel:
			<0x107 0x106 0x105 0x104 0x103 0x102 0x101 0x100>,
			<0x117 0x116 0x115 0x114 0x113 0x112 0x111 0x110>,
			<0 0 0 0 0 0 0 0>;
	- PL110 single mono 4-bit STN panel:
			<0x203 0x202 0x201 0x200>,
			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
	- PL110 dual mono 4-bit STN panel:
			<0x203 0x202 0x201 0x200>, <0 0 0 0>,
			<0x213 0x212 0x211 0x210>,
			<0 0 0 0 0 0 0 0 0 0 0 0>;
	- PL110 single mono 8-bit STN panel:
			<0x207 0x206 0x205 0x204 0x203 0x202 0x201 0x200>,
			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
	- PL110 dual mono 8-bit STN panel:
			<0x207 0x206 0x205 0x204 0x203 0x202 0x201 0x200>,
			<0x217 0x216 0x215 0x214 0x213 0x212 0x211 0x210>,
			<0 0 0 0 0 0 0 0>;
	- PL110 TFT (1:)5:5:5 panel:
			<0x330 0x300 0x301 0x302 0x303 0x304>,
			<0x330 0x310 0x311 0x312 0x313 0x314>,
			<0x330 0x320 0x321 0x322 0x323 0x324>,
			<0 0 0 0 0 0>
	- PL110 and PL111 TFT RGB 888 panel:
			<0x300 0x301 0x302 0x303 0x304 0x305 0x306 0x307>,
			<0x310 0x311 0x312 0x313 0x314 0x315 0x316 0x317>,
			<0x320 0x321 0x322 0x323 0x324 0x325 0x326 0x327>;
	- PL111 single colour STN panel:
			<0x100 0x101 0x102 0x103 0x104 0x105 0x106 0x107>,
			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
	- PL111 dual colour STN panel:
			<0x100 0x101 0x102 0x103 0x104 0x105 0x106 0x107>,
			<0x110 0x111 0x112 0x113 0x114 0x115 0x116 0x117>,
			<0 0 0 0 0 0 0 0>;
	- PL111 single mono 4-bit STN panel:
			<0x200 0x201 0x202 0x203>,
			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
	- PL111 dual mono 4-bit STN panel:
			<0x200 0x201 0x202 0x203>, <0 0 0 0>,
			<0x210 0x211 0x212 0x213>,
			<0 0 0 0 0 0 0 0 0 0 0 0>;
	- PL111 single mono 8-bit STN panel:
			<0x200 0x201 0x202 0x203 0x204 0x205 0x206 0x207>,
			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
	- PL111 dual mono 8-bit STN panel:
			<0x200 0x201 0x202 0x203 0x204 0x205 0x206 0x207>,
			<0x210 0x211 0x212 0x213 0x214 0x215 0x216 0x217>,
			<0 0 0 0 0 0 0 0>;
	- PL111 TFT 4:4:4 panel:
			<0 0 0 0>, <0x300 0x301 0x302 0x303>,
			<0 0 0 0>, <0x310 0x311 0x312 0x313>,
			<0 0 0 0>, <0x320 0x321 0x322 0x323>;
	- PL111 TFT 5:6:5 panel:
			<0 0 0>, <0x300 0x301 0x302 0x303 0x304>,
			<0 0>, <0x310 0x311 0x312 0x313 0x314 0x315>,
			<0 0 0>, <0x320 0x321 0x322 0x323 0x324>;
	- PL111 TFT (1):5:5:5 panel:
			<0 0 0>, <0x300 0x301 0x302 0x303 0x304>,
			<0 0>, <0x330 0x310 0x311 0x312 0x313 0x314>,
			<0 0 0>, <0x320 0x321 0x322 0x323 0x324>;
8<----

Of course the examples above could be #defined.

Such approach would also solve problem with bizarre cases like the
Versatile's (not Express ;-) muxer Russell mentioned (where there is a
de-facto custom wiring used). And no, I had a look at pinmux bindings
and I don't think they fit here at all...

Thoughts?

Pawe=C5=82


