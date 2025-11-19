Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1C34DB46
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Nov 2025 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548926; cv=none; b=HrarI8zZYWE/gas2BZVbAyj6rGrNE8cIZvsoxXANwIhY+arWCAPkUhnZ4hw2iZF3DdzwBF96C/T6GWFp+gjadJbsC1f1TrqZsOO8FrGYWT6HKKFEvI7BUMLPafc/Led+R3msXfdayIOrkmjMXMZAnQjGdkXQpppkT/FbhDM3jOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548926; c=relaxed/simple;
	bh=axdrYB6mxGM65Go6NYsti5ar4KcMv2DrjvvwQ7LGZfY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bKZi9DixxsMNsB8E7KGaqH19VhmZsVx35tLgxxLeEYViil90CpvqIzKWIlgNrNfsyRlW5P18ORJEp1ODoz1fno2lxb9sU7xIajISxx8FV8dtn7jfmsaJz7+tcuqHM0Dzm2/5AWgUPVzUKFSjOiQp1ZDGiuSljJ2JvVv0fZ7JKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4337e3aca0cso73942815ab.1
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Nov 2025 02:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763548923; x=1764153723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5O7ne2WBSqK2Uh1+9CUGZfwygbGsA1NqwmKnl93w1E=;
        b=Lx2KL6yf+utAlqIYVGwFK/6Krt2xsPM58lJUDGO+Ix71rQvZi6RE3KVcNCzoqoR9YQ
         o7KRbHuz0hrtR3hd+rZZLuKNHjphcW+Our3TLXh+K6iFgXhZBW/B4MZoihS6cEyiYsub
         +1zfEP50WxU47kg+VVxB1AySxOwq2kUF7x2fFiCBkSaDB9pmFkcT4w+qOSJq/ssHOTro
         gaLJ9yGQET7xd9/AJd2IKSHzxAu7CQ0EcqwtBLYHFXwRGkz7pRv8O+KpzAwKZbTMKRp5
         gRmpMfUSDDlbZ99JWPqSXuWu0/rdMsdoMO8FyUxH3MNiuG1DuI/sNCt8pP8o9X4rxGpA
         NMjg==
X-Gm-Message-State: AOJu0Yw0sU6kxMI5X4xWcbUuSibwooxef5d8lMmyeInzX+7M9b1KaaOS
	WlNbaW7IJuKRb9fQp8w68hhGcjFj4lCTRUx7PxhWcTDcNzbgu5MS/GzxMKlIIXCfFJbCx+0WR6l
	1Em0oVeIkTcOSLMbrdyb5ZZ1DbGJmHj+O637pLlmYMSuEbLuSW68whRZqNVI=
X-Google-Smtp-Source: AGHT+IEc+kkj1VteTgSjjkYfSRTVtMVnQGhIwG7t5mycJ1XWbbi4MK9DHw6NJNLodoXIdcxRTfkeznbrqMk9oYjmiE/ujAWJEVcj
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:434:74a6:48f3 with SMTP id
 e9e14a558f8ab-4359fe885a3mr15837675ab.19.1763548922859; Wed, 19 Nov 2025
 02:42:02 -0800 (PST)
Date: Wed, 19 Nov 2025 02:42:02 -0800
In-Reply-To: <e69c10c5-ee82-4229-b7b6-e3993442595b@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691d9efa.a70a0220.d98e3.000c.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (6)
From: syzbot <syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com>
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com
Tested-by: syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com

Tested on:

commit:         8b690556 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10921212580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cd7f786c0f5182f
dashboard link: https://syzkaller.appspot.com/bug?extid=5a40432dfe8f86ee657a
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a21212580000

Note: testing is done by a robot and is best-effort only.
