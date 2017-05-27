use strict;
use warnings;
use Test::More;
use Pegex::Parser;
use GraphQL::Grammar;
use Pegex::Tree::Wrap;
use Pegex::Input;
use Data::Dumper;

my $parser = Pegex::Parser->new(
  grammar => GraphQL::Grammar->new,
  receiver => Pegex::Tree::Wrap->new,
);
open my $fh, '<', 't/kitchen-sink.graphql';

my $got = do_lex(join('', <$fh>));
my $expected = eval join '', <DATA>;
local $Data::Dumper::Indent = $Data::Dumper::Sortkeys = $Data::Dumper::Terse = 1;
#open $fh, '>', 'tf'; # uncomment these two lines to regenerate
#print $fh Dumper $got;
is_deeply $got, $expected, 'lex big doc correct' or diag Dumper $got;

done_testing;

sub do_lex {
  my ($text) = @_;
  my $input = Pegex::Input->new(string => $text);
  return $parser->parse($input);
}

__DATA__
{
  'graphql' => [
    [
      {
        'definition' => [
          {
            'operationDefinition' => [
              {
                'operationType' => 'query'
              },
              {
                'name' => 'queryName'
              },
              {
                'variableDefinitions' => [
                  [
                    {
                      'variableDefinition' => [
                        {
                          'variable' => [
                            {
                              'name' => 'foo'
                            }
                          ]
                        },
                        {
                          'type' => [
                            {
                              'namedType' => {
                                'name' => 'ComplexType'
                              }
                            }
                          ]
                        }
                      ]
                    },
                    {
                      'variableDefinition' => [
                        {
                          'variable' => [
                            {
                              'name' => 'site'
                            }
                          ]
                        },
                        {
                          'type' => [
                            {
                              'namedType' => {
                                'name' => 'Site'
                              }
                            }
                          ]
                        },
                        {
                          'defaultValue' => [
                            {
                              'value' => {
                                'enumValue' => {
                                  'name' => 'MOBILE'
                                }
                              }
                            }
                          ]
                        }
                      ]
                    }
                  ]
                ]
              },
              {
                'selectionSet' => [
                  [
                    {
                      'selection' => {
                        'field' => [
                          {
                            'alias' => [
                              {
                                'name' => 'whoever123is'
                              }
                            ]
                          },
                          {
                            'name' => 'node'
                          },
                          {
                            'arguments' => [
                              [
                                {
                                  'argument' => [
                                    {
                                      'name' => 'id'
                                    },
                                    {
                                      'value' => {
                                        'listValue' => [
                                          [
                                            {
                                              'value' => {
                                                'number' => '123'
                                              }
                                            },
                                            {
                                              'value' => {
                                                'number' => '456'
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    }
                                  ]
                                }
                              ]
                            ]
                          },
                          {
                            'selectionSet' => [
                              [
                                {
                                  'selection' => {
                                    'field' => [
                                      {
                                        'name' => 'id'
                                      }
                                    ]
                                  }
                                },
                                {
                                  'selection' => {
                                    'inlineFragment' => [
                                      {
                                        'typeCondition' => [
                                          {
                                            'namedType' => {
                                              'name' => 'User'
                                            }
                                          }
                                        ]
                                      },
                                      {
                                        'directives' => [
                                          {
                                            'directive' => [
                                              {
                                                'name' => 'defer'
                                              }
                                            ]
                                          }
                                        ]
                                      },
                                      {
                                        'selectionSet' => [
                                          [
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'field2'
                                                  },
                                                  {
                                                    'selectionSet' => [
                                                      [
                                                        {
                                                          'selection' => {
                                                            'field' => [
                                                              {
                                                                'name' => 'id'
                                                              }
                                                            ]
                                                          }
                                                        },
                                                        {
                                                          'selection' => {
                                                            'field' => [
                                                              {
                                                                'alias' => [
                                                                  {
                                                                    'name' => 'alias'
                                                                  }
                                                                ]
                                                              },
                                                              {
                                                                'name' => 'field1'
                                                              },
                                                              {
                                                                'arguments' => [
                                                                  [
                                                                    {
                                                                      'argument' => [
                                                                        {
                                                                          'name' => 'first'
                                                                        },
                                                                        {
                                                                          'value' => {
                                                                            'number' => '10'
                                                                          }
                                                                        }
                                                                      ]
                                                                    },
                                                                    {
                                                                      'argument' => [
                                                                        {
                                                                          'name' => 'after'
                                                                        },
                                                                        {
                                                                          'value' => {
                                                                            'variable' => [
                                                                              {
                                                                                'name' => 'foo'
                                                                              }
                                                                            ]
                                                                          }
                                                                        }
                                                                      ]
                                                                    }
                                                                  ]
                                                                ]
                                                              },
                                                              {
                                                                'directives' => [
                                                                  {
                                                                    'directive' => [
                                                                      {
                                                                        'name' => 'include'
                                                                      },
                                                                      {
                                                                        'arguments' => [
                                                                          [
                                                                            {
                                                                              'argument' => [
                                                                                {
                                                                                  'name' => 'if'
                                                                                },
                                                                                {
                                                                                  'value' => {
                                                                                    'variable' => [
                                                                                      {
                                                                                        'name' => 'foo'
                                                                                      }
                                                                                    ]
                                                                                  }
                                                                                }
                                                                              ]
                                                                            }
                                                                          ]
                                                                        ]
                                                                      }
                                                                    ]
                                                                  }
                                                                ]
                                                              },
                                                              {
                                                                'selectionSet' => [
                                                                  [
                                                                    {
                                                                      'selection' => {
                                                                        'field' => [
                                                                          {
                                                                            'name' => 'id'
                                                                          }
                                                                        ]
                                                                      }
                                                                    },
                                                                    {
                                                                      'selection' => {
                                                                        'fragmentSpread' => [
                                                                          {
                                                                            'fragmentName' => {
                                                                              'name' => 'frag'
                                                                            }
                                                                          }
                                                                        ]
                                                                      }
                                                                    }
                                                                  ]
                                                                ]
                                                              }
                                                            ]
                                                          }
                                                        }
                                                      ]
                                                    ]
                                                  }
                                                ]
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  }
                                },
                                {
                                  'selection' => {
                                    'inlineFragment' => [
                                      {
                                        'directives' => [
                                          {
                                            'directive' => [
                                              {
                                                'name' => 'skip'
                                              },
                                              {
                                                'arguments' => [
                                                  [
                                                    {
                                                      'argument' => [
                                                        {
                                                          'name' => 'unless'
                                                        },
                                                        {
                                                          'value' => {
                                                            'variable' => [
                                                              {
                                                                'name' => 'foo'
                                                              }
                                                            ]
                                                          }
                                                        }
                                                      ]
                                                    }
                                                  ]
                                                ]
                                              }
                                            ]
                                          }
                                        ]
                                      },
                                      {
                                        'selectionSet' => [
                                          [
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'id'
                                                  }
                                                ]
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  }
                                },
                                {
                                  'selection' => {
                                    'inlineFragment' => [
                                      {
                                        'selectionSet' => [
                                          [
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'id'
                                                  }
                                                ]
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  }
                                }
                              ]
                            ]
                          }
                        ]
                      }
                    }
                  ]
                ]
              }
            ]
          }
        ]
      },
      {
        'definition' => [
          {
            'operationDefinition' => [
              {
                'operationType' => 'mutation'
              },
              {
                'name' => 'likeStory'
              },
              {
                'selectionSet' => [
                  [
                    {
                      'selection' => {
                        'field' => [
                          {
                            'name' => 'like'
                          },
                          {
                            'arguments' => [
                              [
                                {
                                  'argument' => [
                                    {
                                      'name' => 'story'
                                    },
                                    {
                                      'value' => {
                                        'number' => '123'
                                      }
                                    }
                                  ]
                                }
                              ]
                            ]
                          },
                          {
                            'directives' => [
                              {
                                'directive' => [
                                  {
                                    'name' => 'defer'
                                  }
                                ]
                              }
                            ]
                          },
                          {
                            'selectionSet' => [
                              [
                                {
                                  'selection' => {
                                    'field' => [
                                      {
                                        'name' => 'story'
                                      },
                                      {
                                        'selectionSet' => [
                                          [
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'id'
                                                  }
                                                ]
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  }
                                }
                              ]
                            ]
                          }
                        ]
                      }
                    }
                  ]
                ]
              }
            ]
          }
        ]
      },
      {
        'definition' => [
          {
            'operationDefinition' => [
              {
                'operationType' => 'subscription'
              },
              {
                'name' => 'StoryLikeSubscription'
              },
              {
                'variableDefinitions' => [
                  [
                    {
                      'variableDefinition' => [
                        {
                          'variable' => [
                            {
                              'name' => 'input'
                            }
                          ]
                        },
                        {
                          'type' => [
                            {
                              'namedType' => {
                                'name' => 'StoryLikeSubscribeInput'
                              }
                            }
                          ]
                        }
                      ]
                    }
                  ]
                ]
              },
              {
                'selectionSet' => [
                  [
                    {
                      'selection' => {
                        'field' => [
                          {
                            'name' => 'storyLikeSubscribe'
                          },
                          {
                            'arguments' => [
                              [
                                {
                                  'argument' => [
                                    {
                                      'name' => 'input'
                                    },
                                    {
                                      'value' => {
                                        'variable' => [
                                          {
                                            'name' => 'input'
                                          }
                                        ]
                                      }
                                    }
                                  ]
                                }
                              ]
                            ]
                          },
                          {
                            'selectionSet' => [
                              [
                                {
                                  'selection' => {
                                    'field' => [
                                      {
                                        'name' => 'story'
                                      },
                                      {
                                        'selectionSet' => [
                                          [
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'likers'
                                                  },
                                                  {
                                                    'selectionSet' => [
                                                      [
                                                        {
                                                          'selection' => {
                                                            'field' => [
                                                              {
                                                                'name' => 'count'
                                                              }
                                                            ]
                                                          }
                                                        }
                                                      ]
                                                    ]
                                                  }
                                                ]
                                              }
                                            },
                                            {
                                              'selection' => {
                                                'field' => [
                                                  {
                                                    'name' => 'likeSentence'
                                                  },
                                                  {
                                                    'selectionSet' => [
                                                      [
                                                        {
                                                          'selection' => {
                                                            'field' => [
                                                              {
                                                                'name' => 'text'
                                                              }
                                                            ]
                                                          }
                                                        }
                                                      ]
                                                    ]
                                                  }
                                                ]
                                              }
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  }
                                }
                              ]
                            ]
                          }
                        ]
                      }
                    }
                  ]
                ]
              }
            ]
          }
        ]
      },
      {
        'definition' => [
          {
            'fragmentDefinition' => [
              {
                'fragmentName' => {
                  'name' => 'frag'
                }
              },
              {
                'typeCondition' => [
                  {
                    'namedType' => {
                      'name' => 'Friend'
                    }
                  }
                ]
              },
              {
                'selectionSet' => [
                  [
                    {
                      'selection' => {
                        'field' => [
                          {
                            'name' => 'foo'
                          },
                          {
                            'arguments' => [
                              [
                                {
                                  'argument' => [
                                    {
                                      'name' => 'size'
                                    },
                                    {
                                      'value' => {
                                        'variable' => [
                                          {
                                            'name' => 'size'
                                          }
                                        ]
                                      }
                                    }
                                  ]
                                },
                                {
                                  'argument' => [
                                    {
                                      'name' => 'bar'
                                    },
                                    {
                                      'value' => {
                                        'variable' => [
                                          {
                                            'name' => 'b'
                                          }
                                        ]
                                      }
                                    }
                                  ]
                                },
                                {
                                  'argument' => [
                                    {
                                      'name' => 'obj'
                                    },
                                    {
                                      'value' => {
                                        'objectValue' => [
                                          [
                                            {
                                              'objectField' => [
                                                {
                                                  'name' => 'key'
                                                },
                                                {
                                                  'value' => {
                                                    'string' => 'value'
                                                  }
                                                }
                                              ]
                                            }
                                          ]
                                        ]
                                      }
                                    }
                                  ]
                                }
                              ]
                            ]
                          }
                        ]
                      }
                    }
                  ]
                ]
              }
            ]
          }
        ]
      },
      {
        'definition' => [
          {
            'operationDefinition' => {
              'selectionSet' => [
                [
                  {
                    'selection' => {
                      'field' => [
                        {
                          'name' => 'unnamed'
                        },
                        {
                          'arguments' => [
                            [
                              {
                                'argument' => [
                                  {
                                    'name' => 'truthy'
                                  },
                                  {
                                    'value' => {
                                      'boolean' => 'true'
                                    }
                                  }
                                ]
                              },
                              {
                                'argument' => [
                                  {
                                    'name' => 'falsey'
                                  },
                                  {
                                    'value' => {
                                      'boolean' => 'false'
                                    }
                                  }
                                ]
                              },
                              {
                                'argument' => [
                                  {
                                    'name' => 'nullish'
                                  }
                                ]
                              }
                            ]
                          ]
                        }
                      ]
                    }
                  },
                  {
                    'selection' => {
                      'field' => [
                        {
                          'name' => 'query'
                        }
                      ]
                    }
                  }
                ]
              ]
            }
          }
        ]
      }
    ]
  ]
}
