From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: geode problem
Date: Fri, 28 Apr 2006 08:27:01 +0800
Message-ID: <44516155.6090304@gmail.com>
References: <eb77d7060604261806y4faa1107l5464316fa005266e@mail.gmail.com>	 <4450E412.9080801@gmail.com>	 <eb77d7060604271156n1c72fd90l19abd8a8e5da65da@mail.gmail.com>	 <44514E3B.5060601@gmail.com>	 <eb77d7060604271610q62827dfdsf67db58231aeb347@mail.gmail.com>	 <44515B69.8010303@gmail.com> <eb77d7060604271724k3dd8c9c4w4ddf22bfc7ee6acd@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZGpi-0002jS-Gt
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Apr 2006 17:27:42 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZGpB-0005Kg-3l
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Apr 2006 17:27:09 -0700
Received: from nz-out-0102.google.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZGpA-0007RV-Iq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Apr 2006 17:27:09 -0700
Received: by nz-out-0102.google.com with SMTP id 8so1765122nzo
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Apr 2006 17:27:06 -0700 (PDT)
In-Reply-To: <eb77d7060604271724k3dd8c9c4w4ddf22bfc7ee6acd@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jorge Luis Zapata Muga <jorgeluis.zapata@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Jorge Luis Zapata Muga wrote:
> On 4/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jorge Luis Zapata Muga wrote:
>>> On 4/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>>>> Jorge Luis Zapata Muga wrote:
>>>>> On 4/27/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>>>>>> Jorge Luis Zapata Muga wrote:
>>>> Where are the timings?
>>> sorry!  ok here they are:
>>> 2.4:
>>> mode "640x480-60"
>>>     # D: 25.175 MHz, H: 31.469 kHz, V: 60.055 Hz
>>>     geometry 640 480 640 480 16
>>>     timings 39722 36 36 21 21 88 2
>>>     accel true
>>>     rgba 5/11,6/5,5/0,0/0
>>> endmode
>>>
>>> 2.6:
>>> mode "640x480-60"
>>>     # D: 25.200 MHz, H: 31.500 kHz, V: 60.001 Hz
>>>     geometry 640 480 640 480 16
>>>     timings 39682 48 16 33 10 96 2
>>>     rgba 5/11,6/5,5/0,0/0
>>> endmode
>>>
>> Your timings for 2.4 and 2.6 are slightly different. Have you
>> tried using the 2.4 timings with 2.6?  Though they have the same
>> refresh and resolutions, the horizontal and vertical porches and
>> sync lengths are different, and VGA is very sensitive to these
>> values.
>>
>> Add (or replace the entry with) this in /etc/fb.modes:
>>
>> mode "640x480-60"
>>     # D: 25.175 MHz, H: 31.469 kHz, V: 60.055 Hz
>>     geometry 640 480 640 480 16
>>     timings 39722 36 36 21 21 88 2
>> endmode
>>
>> Then do an 'fbset 640x480-60'
> 
> it didnt work.

Did the driver accept the new timings (do an fbset -i afterwards)?
I want to know before delving on the hardware internals...

Tony


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
