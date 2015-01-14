From: Ssagarr Patil <hugarsagar@outlook.com>
Date: Wed, 14 Jan 2015 16:17:33 +0000
Subject: RE: SSD1306 OLED driver
Message-Id: <BAY176-W319A662A00AEEF5A1D93BAD3410@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Greet,

>
> On Wed, Jan 14, 2015 at 2:51 PM, Ssagarr Patil <hugarsagar@outlook.com> w=
rote:
>> I am also able to run the fbtest application, but with test10 I do not s=
ee 'hello world'
>
> Good!
>
>> pattern. Am I missing something.
>
> That's because that test requires 16 colors, although these aren't used.
>
> If you change ".numcolors =16" to ".numcolors =3D 2" in tests/test010.c,
> it should at least draw some text, but the colors may be of as it
> failed to install
> the 16-color console pallette.
>
Thanks for your response, I did try with setting .numcolors =3D 2 but it do=
esnt help
neither I still don=92t see 'Hello World' on the oled.

Thanks & Regards,
Sagar
 		 	   		  