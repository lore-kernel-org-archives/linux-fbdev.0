From: Austin S Hemmelgarn <ahferroin7@gmail.com>
Date: Thu, 24 Sep 2015 15:21:15 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <560414EB.508@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------ms010605050604040005090601"
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com>
In-Reply-To: <20150924144621.40e26f0a@free-electrons.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud Patard <apatard@mandriva.com>

This is a cryptographically signed message in MIME format.

--------------ms010605050604040005090601
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2015-09-24 08:46, Thomas Petazzoni wrote:
> Hello,
>
> On Thu, 24 Sep 2015 15:27:01 +0300, Tomi Valkeinen wrote:
>
>> fbdev is (more or less) maintained, but it's a deprecated framework. A=
ll
>> new Linux display drivers should be done on DRM.
>>
>> So let's not add any more new fbdev drivers.
>>
>> I will continue to maintain the current fbdev drivers, and I don't min=
d
>> adding some new features to those current drivers, as long as the amou=
nt
>> of code required to add the features stays sensible.
>>
>> I see we have three fbdev drivers in staging: xgifb, fbtft and sm750fb=
,
>> and the question is what to do with those.
>>
>> xgifb was added in 2010, and is still in staging.
>>
>> fbtft looks like maybe some kind of framework on top of fbdev, with
>> fbtft specific subdrivers... I didn't look at it in detail, but my gut=

>> says "never".
>
> fbtft mainly drives some very simple I2C-based or SPI-based displays,
> and DRM is I believe overkill for such displays. Last time I talked
> with Laurent Pinchart about such drivers, I believe he said that such
> simple drivers could probably continue to use the fbdev subsystem.
I have to agree, using DRM _really_ doesn't make sense for these, the=20
devices in question are (AFAIK) simple I2C or SPI connected frame-buffer =

chips that are hooked up to equally simple TFT displays.  There's no 3d=20
acceleration at all from what I can tell, there's _very_ limited 2d=20
acceleration, and most of the stuff that the DRM framework provides=20
call-backs for would have to be done on the CPU anyway.  On top of that, =

it's targeted at small embedded systems with limited memory, and the DRM =

framework is by no-means lightweight (TBH, fbdev isn't really either,=20
but it's much more light weight than DRM).



--------------ms010605050604040005090601
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
cnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcN
AQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxEt+DANBglghkgBZQMEAgMFAKCCAiEwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTUwOTI0MTUyMTE1WjBPBgkq
hkiG9w0BCQQxQgRA27s+7xEebBboRPxJplVdASkkaP4wBCkqBpeX41/p8AY2PdAKNXcRHjcB
Pk6EGuG9NjKJYEdxniXgK/DQKSeztDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAweTEQMA4GA1UE
ChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlD
QSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2Vy
dC5vcmcCAxEt+DCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMHUm9vdCBDQTEe
MBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25p
bmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxEt+DAN
BgkqhkiG9w0BAQEFAASCAgBhj89a18DwMqQZ8STUlRwrC7L5urg9d1ojzh/7cMN3eqPKTXa7
ABwEhnGnUioENYg/ir+KTb7LnOUWWaZra7yrgwi+NTkzAO9pDVtSpiQnTYV3UH5CGRNKNvg+
AewOFtXyauS1NFEvObewKyV/dG77dbw0HkKWqiAfXvO4C1C+0r6IyYW89ghzDo+erGTd525D
RWWraN6be2iAU/pV8X3z0xiW2/73X7e2vYPO25kdgvTS5DSThJnC6/9RlV65NOlfS9AKlkz/
J684629Nq1PNzAPbwZGkrvFsG/mpzUHdnmB6gBlaLbLvfAYy2BjmreUsFew/fSpwYAEZXAqS
6UDbrR9nI6THX3ZojUaEFPyzggGvxLOmreYc94ttqKs1L8OIYkd80Rqd2eD88sdZ9RoCjpKA
HpnM29aBZMeAVMlUOBTX5y3rX+fawCCnf7IoN+HvknCiH7B3myPvdLsfTdDp8HkMvdKlxvit
/yoBt/d5G23htf5SgCtH3rPl8VfH2Ew1AFUedPsNPpAsESY6Tbiv7S8umczp45FJInHPPC0b
pyktNJYaZ3LfDFi3lSMWF0siFcebAXCR8/cGqbKrflB+s+JaQ5tMUOS7uqy91w7fdyWcl0oZ
7cgbLz4ys5rVq+ml2I4OrLAf+AAbXsYMAop228tRqTJ9uJWQCDAUOc73SwAAAAAAAA==
--------------ms010605050604040005090601--
